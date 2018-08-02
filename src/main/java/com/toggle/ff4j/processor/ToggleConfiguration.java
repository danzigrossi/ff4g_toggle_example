package com.toggle.ff4j.processor;

import org.ff4j.FF4j;
import org.ff4j.web.embedded.ConsoleServlet;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;

@Configuration
@ComponentScan(value = {"org.ff4j.spring.boot.web.api", "org.ff4j.services", "org.ff4j.aop", "org.ff4j.spring"})
public class ToggleConfiguration {
	
	@Bean
	@DependsOn(value="ff4j")
	public ServletRegistrationBean getFF4jConsole() {
		ConsoleServlet console = new ConsoleServlet();
		console.setFf4j(ff4j());
	    ServletRegistrationBean bean = new ServletRegistrationBean(
	    		console, "/ff4j-console/*");
//	    bean.addInitParameter(ConsoleConstants.PROVIDER_PARAM_NAME, MyFF4jProvider.class.getCanonicalName());
	    bean.setLoadOnStartup(1);
	    return bean;
	}
	
	@Bean
    public FF4j ff4j() {
        // You cen define ff4j the way you like
        // the simplest is to use XML and InMemory but there are dozens of DB available.
        return new FF4j("ff4j-features.xml");
        
        // Please add ff4j-store-springjdbc for this sample to work..and a Datasource
        //FF4j ff4j = new FF4j();
        //ff4j.setFeatureStore(new FeatureStoreSpringJdbc(myDataSource));
        //ff4j.setPropertiesStore(new PropertyStoreSpringJdbc(myDataSource));
        //ff4j.setEventRepository(new EventRepositorySpringJdbc(myDataSource));
        // Enable auditing
        //ff4j.audit(true);
        // If feature not found in DB, automatically created (as false)
        //ff4j.autoCreate(enableAutoCreate);
    }
}
