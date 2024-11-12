package com._6.demo;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class MvcConfiguration implements WebMvcConfigurer {

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        // Map URLs to templates without needing a controller
        registry.addViewController("/").setViewName("index");
        registry.addViewController("/about").setViewName("about");
        registry.addViewController("/contact").setViewName("contact");
    }
}
