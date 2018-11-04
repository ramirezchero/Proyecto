using FactElec.CapaDatos;
using FactElec.CapaEntidad.RegistroComprobante;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace FactElec.LogicaProceso
{
    public class Lp_Validacion
    {
        public static En_Respuesta ComprobanteValido(En_ComprobanteElectronico comprobante, ref bool esValido)
        {
            En_Respuesta respuesta = new En_Respuesta();
            try
            {
                List<En_Validacion> validaciones = new Da_Validacion().ListarValidaciones();
                //respuesta = ValidarEntidad(validaciones, ref esValido, comprobante);
                if (comprobante.ComprobanteDetalle != null)
                {
                    foreach (En_ComprobanteDetalle detalle in comprobante.ComprobanteDetalle)
                    {
                        respuesta = ValidarEntidad(validaciones, detalle, ref esValido);
                    }
                }
            }
            catch (Exception ex)
            {
                esValido = false;
                respuesta.Codigo = "99";
                respuesta.Descripcion = ex.Message.ToString();
            }
            return respuesta;
        }

        private static En_Respuesta ValidarEntidad<T>(List<En_Validacion> validaciones, T entidad, ref bool esValido)
        {
            PropertyInfo[] propiedades = entidad.GetType().GetProperties();
            string nombreEntidad = entidad.GetType().Name;
            string nombrePropiedad = "";
            try
            {
                foreach (En_Validacion validacion in validaciones)
                {
                    PropertyInfo propiedad = (from p in propiedades
                                              where p.Name == validacion.Propiedad
                                              select p).FirstOrDefault();

                    if (propiedad != null)
                    {
                        nombrePropiedad = propiedad.Name;
                        object valor = entidad.GetType().GetProperty(nombrePropiedad).GetValue(entidad, null);
                        switch (validacion.TipoDeDato)
                        {
                            case TipoDato.Boolean: break;
                            case TipoDato.Date: break;
                            case TipoDato.Decimal:
                                {
                                    if (valor != null)
                                    {
                                        decimal valorDecimal = (decimal)valor;
                                        if (validacion.Condicion == Condicion.Mandatorio && valorDecimal <= 0)
                                        {
                                            esValido = false;
                                            return Respuesta("02", $"La propiedad {nombrePropiedad} de la entidad {nombreEntidad} es mandatoria por lo tanto debe ser mayor que cero.");
                                        }
                                        if (valorDecimal < 0)
                                        {
                                            esValido = false;
                                            return Respuesta("02", $"La propiedad {nombrePropiedad} de la entidad {nombreEntidad} no debe ser menor que cero.");
                                        }
                                    }
                                    break;
                                }
                            case TipoDato.String:
                                {
                                    string valorString = (string)valor;
                                    if (validacion.Condicion == Condicion.Mandatorio && EsTextoVacio(valorString))
                                    {
                                        esValido = false;
                                        return Respuesta("01", $"La propiedad {nombrePropiedad} de la entidad {nombreEntidad} es mandatoria.");
                                    }
                                    if (!EsTextoVacio(valorString))
                                    {
                                        if (valorString.Length > validacion.TamanioMax)
                                        {
                                            esValido = false;
                                            return Respuesta("01", $"La propiedad {nombrePropiedad} de la entidad {nombreEntidad} no debe se mayor de {validacion.TamanioMax} caracteres.");
                                        }
                                        if (!EsTextoVacio(validacion.Formato))
                                        {
                                            Regex regex = new Regex(validacion.Formato);
                                            Match match = regex.Match(valorString);
                                            if (!match.Success)
                                            {
                                                esValido = false;
                                                return Respuesta("01", $"La propiedad {nombrePropiedad} de la entidad {nombreEntidad} no cumple con el formato \"{validacion.Formato}\".");
                                            }
                                        }
                                    }
                                    break;
                                };
                            case TipoDato.ArrayString:
                                {
                                    List<string> valorArray = (List<string>)valor;
                                    if (validacion.Condicion == Condicion.Mandatorio)
                                    {
                                        if (valorArray == null || valorArray.Count == 0)
                                        {
                                            esValido = false;
                                            return Respuesta("01", $"La propiedad {nombrePropiedad} de la entidad {nombreEntidad} es mandatoria.");
                                        }
                                        foreach (string texto in valorArray)
                                        {
                                            if (EsTextoVacio(texto))
                                            {
                                                esValido = false;
                                                return Respuesta("01", $"La propiedad {nombrePropiedad} de la entidad {nombreEntidad} contiene un elemento vacío.");
                                            }
                                            if (texto.Length > validacion.TamanioMax)
                                            {
                                                esValido = false;
                                                return Respuesta("01", $"La propiedad {nombrePropiedad} de la entidad {nombreEntidad} contiene un elemento que excede los {validacion.TamanioMax} caracteres.");
                                            }
                                            if (!EsTextoVacio(validacion.Formato))
                                            {
                                                Regex regex = new Regex(validacion.Formato);
                                                Match match = regex.Match(texto);
                                                if (!match.Success)
                                                {
                                                    esValido = false;
                                                    return Respuesta("01", $"La propiedad {nombrePropiedad} de la entidad {nombreEntidad} contiene un elemento que no cumple con el formato \"{validacion.Formato}\".");
                                                }
                                            }
                                        }
                                    }
                                    break;
                                }
                            default: throw new ArgumentException("No se ha definido el tipo de dato.");
                        }
                    }
                }
                esValido = true;
                return Respuesta("0", $"Entidad {nombreEntidad} validada correctamente.");
            }
            catch (Exception ex)
            {
                throw new Exception($"Ocurrió un error en la propiedad {nombrePropiedad} de la entidad {nombreEntidad}, mensaje del error: {ex.Message.ToString()}");
            }
        }

        private static En_Respuesta Respuesta(string codigo, string descripcion) => new En_Respuesta(codigo, descripcion);

        private static bool EsTextoVacio(string texto)
        {
            if (string.IsNullOrEmpty(texto) || string.IsNullOrWhiteSpace(texto))
                return true;
            else
                return false;
        }
    }
}
