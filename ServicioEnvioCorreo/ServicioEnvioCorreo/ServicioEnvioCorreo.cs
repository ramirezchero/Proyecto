using ServicioEnvioCorreo.Negocio;
using System.ComponentModel;
using System.ServiceProcess;
using System.Timers;

[assembly: ServicioEnvioCorreo.Log.Configuracion("SwinECO")]
namespace ServicioEnvioCorreo
{
    public partial class ServicioEnvioCorreo : ServiceBase
    {
        readonly log4net.ILog log = null;
        Timer temporizador = new Timer();

        public ServicioEnvioCorreo()
        {
            InitializeComponent();
            InitializeComponent();
            log = log4net.LogManager.GetLogger(typeof(ServicioEnvioCorreo));
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
            PrepararEnvio();
            ProcesarEnvio();
            temporizador.Interval = 60000;
            temporizador.Start();
        }

        private void PrepararEnvio()
        {
            if (!BgwPrepararCorreo.IsBusy)
            {
                BgwPrepararCorreo.RunWorkerAsync();
            }
        }

        private void ProcesarEnvio()
        {
            if (!BgwEnviarCorreos.IsBusy)
            {
                BgwEnviarCorreos.RunWorkerAsync();
            }
        }

        private void BgwEnviarCorreos_DoWork(object sender, DoWorkEventArgs e)
        {
            Ne_Correo neCorreo = new Ne_Correo();
            neCorreo.ProcesarEnvioCorreo();
        }

        private void BgwPrepararCorreo_DoWork(object sender, DoWorkEventArgs e)
        {
            Ne_Correo neCorreo = new Ne_Correo();
            neCorreo.ProcesarRegistroCorreo();
        }
    }
}
