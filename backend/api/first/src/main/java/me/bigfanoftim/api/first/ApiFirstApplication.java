package me.bigfanoftim.api.first;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(
        scanBasePackages = {
                "me.bigfanoftim.api.first",
                "me.bigfanoftim.core.api"
        }
)
public class ApiFirstApplication {

    public static void main(String[] args) {
        SpringApplication.run(ApiFirstApplication.class, args);
    }
}
