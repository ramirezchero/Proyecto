using FactElec.CapaEntidad.RegistroComprobante;
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Web.Http;

[assembly: FactElec.Log.Configuracion("WebApi")]
namespace FactElec.WebApi.Controllers
{
    public class ComprobanteController : ApiController
    {
        readonly log4net.ILog log = null;
        public ComprobanteController() => log = log4net.LogManager.GetLogger(typeof(ComprobanteController));

        // GET: api/Comprobante
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET: api/Comprobante/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/Comprobante        
        public HttpResponseMessage Post([FromBody]En_ComprobanteElectronico comprobante)
        {
            try
            {
                log.Info("Inicio del proceso.");
                LogicaProceso.RegistroComprobante.Lp_Metodos lp = new LogicaProceso.RegistroComprobante.Lp_Metodos();
                En_Respuesta oRespuesta = new En_Respuesta();
                oRespuesta = lp.RegistroComprobante(comprobante);
                log.Info("Fin del proceso");
                return Request.CreateResponse(HttpStatusCode.Created, oRespuesta);
            }
            catch (Exception ex)
            {
                log.Error("Ocurrió un error.", ex);
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex);
            }
            finally
            {
                log.Info("Fin del proceso.");
            }
        }

        // PUT: api/Comprobante/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Comprobante/5
        public void Delete(int id)
        {
        }
    }
}
