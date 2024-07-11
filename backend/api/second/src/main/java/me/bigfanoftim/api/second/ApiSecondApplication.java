package me.bigfanoftim.api.second;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(
        scanBasePackages = {
                "me.bigfanoftim.api.second",
                "me.bigfanoftim.core.api"
        }
)
public class ApiSecondApplication {

    public static void main(String[] args) {
        SpringApplication.run(ApiSecondApplication.class, args);
    }
}
