package br.com.neurosync.api.controller;

import br.com.neurosync.api.dto.PreferenciaSensorialRequest;
import br.com.neurosync.api.dto.PreferenciaSensorialResponse;
import br.com.neurosync.api.service.PreferenciaSensorialService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/preferencias-sensoriais")
public class PreferenciaSensorialController {

    private final PreferenciaSensorialService preferenciaSensorialService;

    public PreferenciaSensorialController(PreferenciaSensorialService preferenciaSensorialService) {
        this.preferenciaSensorialService = preferenciaSensorialService;
    }

    @PostMapping
    @PreAuthorize("hasAnyAuthority('ROLE_ADMIN_SISTEMA','ROLE_GESTOR','ROLE_RH_INCLUSAO','ROLE_COLABORADOR','ROLE_COLABORADOR_NEURODIVERGENTE')")
    public ResponseEntity<PreferenciaSensorialResponse> criar(@Valid @RequestBody PreferenciaSensorialRequest request) {
        return ResponseEntity.ok(preferenciaSensorialService.criar(request));
    }

    @GetMapping("/usuario/{usuarioId}")
    @PreAuthorize("hasAnyAuthority('ROLE_ADMIN_SISTEMA','ROLE_GESTOR','ROLE_RH_INCLUSAO','ROLE_COLABORADOR','ROLE_COLABORADOR_NEURODIVERGENTE')")
    public ResponseEntity<List<PreferenciaSensorialResponse>> listarPorUsuario(@PathVariable Long usuarioId) {
        return ResponseEntity.ok(preferenciaSensorialService.buscarPorUsuario(usuarioId));
    }
}
