package com._6.demo;

import org.springframework.core.io.ClassPathResource;
import org.springframework.util.StreamUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

@RestController
public class HomeController
{

    @GetMapping("/")
    public String index() throws IOException {
        ClassPathResource htmlFile = new ClassPathResource("templates/index.html");
        return StreamUtils.copyToString(htmlFile.getInputStream(), StandardCharsets.UTF_8);

    }
    @GetMapping("/listing")
    public String listing() throws IOException {
        ClassPathResource htmlFile = new ClassPathResource("templates/listing.html");
        return StreamUtils.copyToString(htmlFile.getInputStream(), StandardCharsets.UTF_8);
    }
}
