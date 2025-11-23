package br.com.neurosync.api.controller;

import br.com.neurosync.api.dto.ZonaSensorialResponse;
import br.com.neurosync.api.service.ZonaSensorialService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/zonas-sensoriais")
public class ZonaSensorialController {

    private final ZonaSensorialService zonaSensorialService;

    public ZonaSensorialController(ZonaSensorialService zonaSensorialService) {
        this.zonaSensorialService = zonaSensorialService;
    }

    @GetMapping
    @PreAuthorize("hasAnyAuthority('ROLE_ADMIN_SISTEMA','ROLE_GESTOR','ROLE_RH_INCLUSAO','ROLE_COLABORADOR','ROLE_COLABORADOR_NEURODIVERGENTE')")
    public ResponseEntity<List<ZonaSensorialResponse>> listar() {
        return ResponseEntity.ok(zonaSensorialService.listar());
    }
}
