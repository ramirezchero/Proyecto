﻿using ServicioRepresentImpresa.Negocio;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using System.Timers;

[assembly: ServicioRepresentImpresa.Log.Configuracion("SwinRPDF")]
namespace ServicioRepresentImpresa
{
    public partial class ServicioRepresentImpresa : ServiceBase
    {
        readonly log4net.ILog log = null;
        Timer temporizador = new Timer();

        public ServicioRepresentImpresa()
        {
            InitializeComponent();
            log = log4net.LogManager.GetLogger(typeof(ServicioRepresentImpresa));
            temporizador = new Timer(1);
            temporizador.Elapsed += new ElapsedEventHandler(Temporizador_Elapsed);
        }

        #region "Métodos servicios"

        public void Iniciando()
        {
            temporizador.Start();
        }
        protected override void OnStart(string[] args)
        {
            temporizador.Start();
        }

        protected override void OnStop()
        {
            temporizador.Stop();
        }

        protected override void OnContinue()
        {
            temporizador.Start();
        }

        protected override void OnPause()
        {
            temporizador.Stop();
        }
        #endregion

        private void Temporizador_Elapsed(object sender, ElapsedEventArgs e)
        {
            temporizador.Stop();
            ProcesarEnvio();
            temporizador.Interval = 60000;
            temporizador.Start();
        }

        private void ProcesarEnvio()
        {
            if (!BgwGenerarPdf.IsBusy)
            {
                BgwGenerarPdf.RunWorkerAsync();
            }
        }

        private void BgwEnviarComprobantes_DoWork(object sender, DoWorkEventArgs e)
        {
            Ne_Comprobante neComprobante = new Ne_Comprobante();
            neComprobante.ProcesarRepresentacionImpresa();
        }
    }
}
