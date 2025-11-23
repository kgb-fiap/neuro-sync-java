package br.com.neurosync.api.config;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Info;
import org.springframework.context.annotation.Configuration;

@Configuration
@OpenAPIDefinition(
        info = @Info(
                title = "Neuro-Sync API",
                version = "v1",
                description = "API REST para inclusão produtiva com monitoramento sensorial e reservas de estações."
        )
)
public class OpenApiConfig {
}
