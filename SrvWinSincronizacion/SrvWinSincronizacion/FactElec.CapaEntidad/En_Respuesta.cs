﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FactElec.EntidadNegocio
{
    public class En_Respuesta
    {
        public string Codigo { get; set; }

        public long Idcomprobante { get; set; }

        public byte[] Archivo { get; set; }

        public string Descripcion { get; set; }

        public string FecharespuestaSunat { get; set; }

        public string HoraRespuestaSunat { get; set; }

        public string[] Detalle { get; set; }

    }
}
