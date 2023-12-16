//package com.teachingassistant.listener;
//
//import static org.slf4j.LoggerFactory.getLogger;
//
//import javax.servlet.ServletContextEvent;
//import javax.servlet.ServletContextListener;
//
//import org.slf4j.Logger;
//
//public class ServletListenerConfig implements ServletContextListener {
//
//	Logger logger = null;
//
//	@Override
//	public void contextInitialized(ServletContextEvent servletContextEvent) {
//		System.setProperty("org.slf4j.simpleLogger.showDateTime", "true");
//		System.setProperty("org.slf4j.simpleLogger.defaultLogLevel", "info");
//		System.setProperty("org.slf4j.simpleLogger.dateTimeFormat", "yyyy-MM-dd::HH-mm-ss-SSS");
//		logger = getLogger(this.getClass().getName());
//		logger.error("I have hit contextInitialized: " + servletContextEvent.getServletContext().toString());
//	}
//
//	@Override
//	public void contextDestroyed(ServletContextEvent servletContextEvent) {
//		logger.debug("I have hit contextDestroyed.");
//	}
//}
