package br.com.neurosync.api.controller;

import br.com.neurosync.api.dto.EstacaoTrabalhoRequest;
import br.com.neurosync.api.dto.EstacaoTrabalhoResponse;
import br.com.neurosync.api.service.EstacaoTrabalhoService;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/estacoes")
public class EstacaoTrabalhoController {

    private final EstacaoTrabalhoService estacaoTrabalhoService;

    public EstacaoTrabalhoController(EstacaoTrabalhoService estacaoTrabalhoService) {
        this.estacaoTrabalhoService = estacaoTrabalhoService;
    }

    @GetMapping
    @PreAuthorize("hasAnyAuthority('ROLE_ADMIN_SISTEMA','ROLE_GESTOR','ROLE_RH_INCLUSAO','ROLE_COLABORADOR','ROLE_COLABORADOR_NEURODIVERGENTE')")
    public ResponseEntity<Page<EstacaoTrabalhoResponse>> listar(
            @RequestParam(required = false) Long zonaId,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String permiteReserva,
            @PageableDefault Pageable pageable) {
        return ResponseEntity.ok(estacaoTrabalhoService.listar(zonaId, status, permiteReserva, pageable));
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyAuthority('ROLE_ADMIN_SISTEMA','ROLE_GESTOR','ROLE_RH_INCLUSAO','ROLE_COLABORADOR','ROLE_COLABORADOR_NEURODIVERGENTE')")
    public ResponseEntity<EstacaoTrabalhoResponse> buscar(@PathVariable Long id) {
        return ResponseEntity.ok(estacaoTrabalhoService.buscarPorId(id));
    }

    @PostMapping
    @PreAuthorize("hasAnyAuthority('ROLE_ADMIN_SISTEMA','ROLE_GESTOR')")
    public ResponseEntity<EstacaoTrabalhoResponse> criar(@Valid @RequestBody EstacaoTrabalhoRequest request) {
        return ResponseEntity.ok(estacaoTrabalhoService.criar(request));
    }
}
