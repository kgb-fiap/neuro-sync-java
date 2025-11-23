package br.com.neurosync.api.controller;

import br.com.neurosync.api.dto.IndicadorResponse;
import br.com.neurosync.api.service.IndicadorService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;

@RestController
@RequestMapping("/api/indicadores")
public class IndicadorController {

    private final IndicadorService indicadorService;

    public IndicadorController(IndicadorService indicadorService) {
        this.indicadorService = indicadorService;
    }

    @GetMapping("/estacoes/{id}/indice-conforto")
    @PreAuthorize("hasAnyAuthority('ROLE_ADMIN_SISTEMA','ROLE_GESTOR','ROLE_RH_INCLUSAO','ROLE_COLABORADOR','ROLE_COLABORADOR_NEURODIVERGENTE')")
    public ResponseEntity<IndicadorResponse> indiceConforto(
            @PathVariable Long id,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime inicio,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime fim) {
        return ResponseEntity.ok(indicadorService.calcularIndiceConforto(id, inicio, fim));
    }

    @GetMapping("/estacoes/{id}/taxa-ocupacao")
    @PreAuthorize("hasAnyAuthority('ROLE_ADMIN_SISTEMA','ROLE_GESTOR','ROLE_RH_INCLUSAO','ROLE_COLABORADOR','ROLE_COLABORADOR_NEURODIVERGENTE')")
    public ResponseEntity<IndicadorResponse> taxaOcupacao(
            @PathVariable Long id,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime inicio,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime fim) {
        return ResponseEntity.ok(indicadorService.calcularTaxaOcupacao(id, inicio, fim));
    }
}
