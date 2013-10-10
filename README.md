SimpleCos v2.0
========

SimpleCos es un sencillo aplicativo de software para tarificar
el consumo de minutos de los clientes. Actualmente
tiene la capacidad de administrar multiples terminales freeswitch
por medio del modulo xml_curl y mod_nibble_curl para tarificacion
remota.

16 JULIO 2013
=============
Nuevas modificaciones.
 * AccountCode por cuenta para gestion de la tarificacion.
 * Pasarela externa maneja troncales y distribuibles con mod_distributor
 * Conecta a FS atraves de mod_event_socket.
 
FUTURO
======
 * Autoencaminamiento de bajao costo (mod_lcr)
 * Cuenta reseller
 
Caracteristicas
==============

 * Rails 3.2.8
 * Thin(recomendado)

Caracteristicas Administracion
==============================

 * Gestion multiples terminales freeswitch con tarificacion distribuida
 * Gestion de clientes y cuentas de consumo.
 * Plan de consumo para clientes.
 * Sencillo CDR

Caracteristicas Clientes
==========

 * Peticion de recarga, consumo
 * CDR diario, semanal y mensual.
 * Ultimas 10 llamadas. (aun no implementado)

Recomendaciones
==============

 * You must ensure that the "accept-blind-reg" parameter is set to "false" in sofia.conf.xml, otherwise your web application will not get called. 
 
 
Demonios
--------

  * iniciar scripts/delayed_jobs  para CDR
  * iniciar rake daemon:monitor:start para el monitoreo de las cuentas clientes

Freeswitch
==========

 * Modulos: mod_nibblebill_curl, mod_xml_curl, mod_xml_cdr, mod_limit, mod_distributor
 * Audios: {i18}/overthelimit.wav, {i18n}/no_more_funds.wav

Configuracion
-------------
 * Activar modulo mod_xml_curl, configurar para que apunte a: app/dialplan.xml, app/directory.xml, app/configuration.xml
 * compilar y activar modulo mod_nibblebill_curl, configurar: url_lookup => app/bill/${nibble_account}, url_save => app/bill/${nibble_account}
 

