using FactElec.CapaEntidad.RegistroComprobante;

[assembly: FactElec.Log.Configuracion("WCFService")]
namespace FactElec.WebService
{
    public class Service1 : IService1
    {
        readonly log4net.ILog log = null;
        public Service1() => log = log4net.LogManager.GetLogger(typeof(Service1));

        public En_Respuesta RegistroComprobante(En_ComprobanteElectronico Comprobante)
        {
            log.Info("Inicio del proceso.");
            En_Respuesta oRespuesta = new En_Respuesta();

            if (Comprobante.TipoComprobante.Trim() == "01" || Comprobante.TipoComprobante.Trim() == "03") {
                LogicaProceso.RegistroComprobante.Lp_Metodo_Invoice lp = new LogicaProceso.RegistroComprobante.Lp_Metodo_Invoice();
                oRespuesta = lp.RegistroComprobante(Comprobante);
            }
            if (Comprobante.TipoComprobante.Trim() == "07")
            {
                LogicaProceso.RegistroComprobante.Lp_Metodo_CreditNote lp = new LogicaProceso.RegistroComprobante.Lp_Metodo_CreditNote();
                oRespuesta = lp.RegistroComprobante(Comprobante);
            }
            if (Comprobante.TipoComprobante.Trim() == "08")
            {
                LogicaProceso.RegistroComprobante.Lp_Metodo_DebitNote lp = new LogicaProceso.RegistroComprobante.Lp_Metodo_DebitNote();
                oRespuesta = lp.RegistroComprobante(Comprobante);
            }
            log.Info("Fin del proceso");
            return oRespuesta;
        }
    }
}
