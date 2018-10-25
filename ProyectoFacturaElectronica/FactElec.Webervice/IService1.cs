﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using FactElec.CapaEntidad.RegistroComprobante;

namespace FactElec.Webervice
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de interfaz "IService1" en el código y en el archivo de configuración a la vez.
    [ServiceContract]
    public interface IService1
    {
                
        [OperationContract]
        bool RegistroComprobante(ComprobanteElectronico Comprobante);
        
    }
    
}
