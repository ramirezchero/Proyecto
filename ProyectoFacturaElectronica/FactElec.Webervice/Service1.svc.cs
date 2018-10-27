using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

using FactElec.CapaEntidad.RegistroComprobante;

namespace FactElec.Webervice
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de clase "Service1" en el código, en svc y en el archivo de configuración.
    // NOTE: para iniciar el Cliente de prueba WCF para probar este servicio, seleccione Service1.svc o Service1.svc.cs en el Explorador de soluciones e inicie la depuración.
    public class Service1 : IService1
    {
        

        public bool RegistroComprobante(En_ComprobanteElectronico Comprobante)
        {
            LogicaProceso.RegistroComprobante.Lp_Metodos lp = new LogicaProceso.RegistroComprobante.Lp_Metodos();
            lp.RegistroComprobante(Comprobante);
            return true;
        }


       
    }
}
