using FactElec.CapaEntidad.RegistroComprobante;

[assembly: FactElec.Log.Configuracion("WCFService")]
namespace FactElec.Webervice
{
    public class Service1 : IService1
    {
        readonly log4net.ILog log = null;
        public Service1() => log = log4net.LogManager.GetLogger(typeof(Service1));

        public bool RegistroComprobante(En_ComprobanteElectronico Comprobante)
        {
            log.Info("Inicio del proceso.");
            LogicaProceso.RegistroComprobante.Lp_Metodos lp = new LogicaProceso.RegistroComprobante.Lp_Metodos();
            lp.RegistroComprobante(Comprobante);
            log.Info("Fin del proceso");
            return true;
        }
    }
}
