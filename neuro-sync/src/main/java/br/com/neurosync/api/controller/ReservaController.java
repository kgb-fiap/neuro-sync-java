package br.com.neurosync.api.controller;

import br.com.neurosync.api.dto.AvaliacaoRequest;
import br.com.neurosync.api.dto.AvaliacaoResponse;
import br.com.neurosync.api.dto.CompatibilidadeResponse;
import br.com.neurosync.api.dto.ReservaRequest;
import br.com.neurosync.api.dto.ReservaResponse;
import br.com.neurosync.api.service.IndicadorService;
import br.com.neurosync.api.service.ReservaService;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@RestController
@RequestMapping("/api/reservas")
public class ReservaController {

    private final ReservaService reservaService;
    private final IndicadorService indicadorService;

    public ReservaController(ReservaService reservaService, IndicadorService indicadorService) {
        this.reservaService = reservaService;
        this.indicadorService = indicadorService;
    }

    @GetMapping
    @PreAuthorize("hasAnyAuthority('ROLE_ADMIN_SISTEMA','ROLE_GESTOR','ROLE_RH_INCLUSAO','ROLE_COLABORADOR','ROLE_COLABORADOR_NEURODIVERGENTE')")
    public ResponseEntity<Page<ReservaResponse>> listar(
            @RequestParam(required = false) Long usuarioId,
            @RequestParam(required = false) Long statusId,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime inicio,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime fim,
            @PageableDefault Pageable pageable) {
        return ResponseEntity.ok(reservaService.listar(usuarioId, statusId, inicio, fim, pageable));
    }

    @PostMapping
    @PreAuthorize("hasAnyAuthority('ROLE_ADMIN_SISTEMA','ROLE_GESTOR','ROLE_COLABORADOR','ROLE_COLABORADOR_NEURODIVERGENTE')")
    public ResponseEntity<ReservaResponse> criar(@Valid @RequestBody ReservaRequest request) {
        return ResponseEntity.ok(reservaService.criarComProcedure(request));
    }

    @PostMapping("/avaliacoes")
    @PreAuthorize("hasAnyAuthority('ROLE_ADMIN_SISTEMA','ROLE_GESTOR','ROLE_COLABORADOR','ROLE_COLABORADOR_NEURODIVERGENTE')")
    public ResponseEntity<AvaliacaoResponse> avaliar(@Valid @RequestBody AvaliacaoRequest request) {
        return ResponseEntity.ok(reservaService.criarAvaliacaoComProcedure(request));
    }

    @GetMapping("/{id}/compatibilidade")
    @PreAuthorize("hasAnyAuthority('ROLE_ADMIN_SISTEMA','ROLE_GESTOR','ROLE_RH_INCLUSAO','ROLE_COLABORADOR','ROLE_COLABORADOR_NEURODIVERGENTE')")
    public ResponseEntity<CompatibilidadeResponse> compatibilidade(@PathVariable Long id) {
        return ResponseEntity.ok(indicadorService.verificarCompatibilidade(id));
    }
}
