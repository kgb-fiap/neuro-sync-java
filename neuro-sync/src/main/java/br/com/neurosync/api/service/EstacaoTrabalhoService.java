package br.com.neurosync.api.service;

import br.com.neurosync.api.dto.EstacaoTrabalhoRequest;
import br.com.neurosync.api.dto.EstacaoTrabalhoResponse;
import br.com.neurosync.api.entity.EstacaoTrabalho;
import br.com.neurosync.api.entity.ZonaSensorial;
import br.com.neurosync.api.exception.NotFoundException;
import br.com.neurosync.api.mapper.EstacaoTrabalhoMapper;
import br.com.neurosync.api.repository.EstacaoTrabalhoRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
public class EstacaoTrabalhoService {

    private final EstacaoTrabalhoRepository estacaoTrabalhoRepository;
    private final ZonaSensorialService zonaSensorialService;

    public EstacaoTrabalhoService(EstacaoTrabalhoRepository estacaoTrabalhoRepository, ZonaSensorialService zonaSensorialService) {
        this.estacaoTrabalhoRepository = estacaoTrabalhoRepository;
        this.zonaSensorialService = zonaSensorialService;
    }

    @Transactional(readOnly = true)
    public Page<EstacaoTrabalhoResponse> listar(Long zonaId, String status, String permiteReserva, Pageable pageable) {
        return estacaoTrabalhoRepository.buscarComFiltros(zonaId, status, permiteReserva, pageable)
                .map(EstacaoTrabalhoMapper::toResponse);
    }

    @Transactional(readOnly = true)
    public EstacaoTrabalho buscarEntidade(Long id) {
        return estacaoTrabalhoRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Estação não encontrada"));
    }

    @Transactional(readOnly = true)
    public EstacaoTrabalhoResponse buscarPorId(Long id) {
        return EstacaoTrabalhoMapper.toResponse(buscarEntidade(id));
    }

    @Transactional
    public EstacaoTrabalhoResponse criar(EstacaoTrabalhoRequest request) {
        ZonaSensorial zona = zonaSensorialService.buscarEntidade(request.getZonaSensorialId());

        EstacaoTrabalho estacao = new EstacaoTrabalho();
        estacao.setZonaSensorial(zona);
        estacao.setCodigoEstacao(request.getCodigoEstacao());
        estacao.setDescricao(request.getDescricao());
        estacao.setPermiteReserva(request.getPermiteReserva() != null ? request.getPermiteReserva() : "S");
        estacao.setPermiteUsoEspontaneo(request.getPermiteUsoEspontaneo() != null ? request.getPermiteUsoEspontaneo() : "S");
        estacao.setStatusEstacao(request.getStatusEstacao() != null ? request.getStatusEstacao() : "ATIVA");
        estacao.setObservacoes(request.getObservacoes());
        estacao.setDataCadastro(LocalDateTime.now());

        EstacaoTrabalho salva = estacaoTrabalhoRepository.save(estacao);
        return EstacaoTrabalhoMapper.toResponse(salva);
    }
}
