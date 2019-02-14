using FactElec.LogicaNegocio;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Timers;
using Timer = System.Timers.Timer;
[assembly: FactElec.Log.Configuracion("SwinSE")]
namespace ServWinSincronizacion
{
    public partial class ServicioSincronizacion : ServiceBase
    {
        readonly log4net.ILog log = null;
        //public Service1() => log = log4net.LogManager.GetLogger(typeof(Service1));

        Timer temporizador = new Timer();
        public ServicioSincronizacion()
        {
            InitializeComponent();
            //Empiece en un segundo
            temporizador = new Timer(1 * 1000);
            log = log4net.LogManager.GetLogger(typeof(ServicioSincronizacion));
            //ejecutamos el evento
            temporizador.Elapsed += new ElapsedEventHandler(Temporizador_Elapsed);
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

        private void Temporizador_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            temporizador.Interval = 1 * 1000;
            temporizador.Enabled = false;
            temporizador.AutoReset = false;
            temporizador.Stop();
            ProcesarRespuesta();
            temporizador.Enabled = true;
            temporizador.AutoReset = true;
            temporizador.Start();
        }

        public void Iniciando()
        {

            temporizador.Interval = 1 * 1000;
            temporizador.Enabled = false;
            temporizador.AutoReset = false;
            temporizador.Stop();
            ProcesarRespuesta();
            temporizador.Enabled = true;
            temporizador.AutoReset = true;
            temporizador.Start();

        }

        private void bgwRespuestaSunat_DoWork(object sender, DoWorkEventArgs e)
        {
            Ln_comprobante oComprobante = new Ln_comprobante();
            oComprobante.ProcesarCDR();
        }

        void ProcesarRespuesta() {
            if (!bgwRespuestaSunat.IsBusy) {
                bgwRespuestaSunat.RunWorkerAsync();
            }


        }
    }
}
