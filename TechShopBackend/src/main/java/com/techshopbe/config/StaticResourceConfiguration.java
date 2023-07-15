package com.techshopbe.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class StaticResourceConfiguration implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
    	// add new url to get resources - default is /images/console1.jpeg -> api/v1/images/...
        registry.addResourceHandler("/api/v1/**")
            .addResourceLocations("classpath:/static/");
    }
}
