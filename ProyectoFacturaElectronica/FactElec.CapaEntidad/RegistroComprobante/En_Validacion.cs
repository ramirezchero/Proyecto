namespace FactElec.CapaEntidad.RegistroComprobante
{
    public class En_Validacion
    { 
        public En_Validacion(string propiedad, Condicion condicion, TipoDato tipoDeDato, int tamanioMax, string formato)
        {
            Propiedad = propiedad;            
            Condicion = condicion;
            TipoDeDato = tipoDeDato;
            TamanioMax = tamanioMax;
            Formato = formato;
        }
        public string Propiedad { get; set; }        
        public Condicion Condicion { get; set; }
        public TipoDato TipoDeDato { get; set; }
        public int TamanioMax { get; set; }
        public string Formato { get; set; }
    }

    public enum Condicion
    {
        Condicional,
        Mandatorio
    }

    public enum TipoDato
    {
        Decimal,
        String,
        Date,
        Boolean,
        ArrayString
    }
}
