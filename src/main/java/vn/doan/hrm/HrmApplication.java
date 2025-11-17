package vn.doan.hrm;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

// @SpringBootApplication
@SpringBootApplication(exclude = org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class)

public class HrmApplication {
	public static void main(String[] args) {
		ApplicationContext context = SpringApplication.run(HrmApplication.class, args);
		System.out.println("Bean definition count: " + context.getBeanDefinitionCount());
	}

}
