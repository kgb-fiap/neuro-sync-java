package br.com.neurosync.api.service;

import br.com.neurosync.api.dto.CompatibilidadeResponse;
import br.com.neurosync.api.dto.IndicadorResponse;
import br.com.neurosync.api.entity.ReservaEstacao;
import br.com.neurosync.api.entity.EstacaoTrabalho;
import br.com.neurosync.api.exception.NotFoundException;
import br.com.neurosync.api.repository.EstacaoTrabalhoRepository;
import br.com.neurosync.api.repository.ReservaEstacaoRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@Service
public class IndicadorService {

    private final EstacaoTrabalhoRepository estacaoTrabalhoRepository;
    private final ReservaEstacaoRepository reservaEstacaoRepository;

    @PersistenceContext
    private EntityManager entityManager;

    public IndicadorService(EstacaoTrabalhoRepository estacaoTrabalhoRepository, ReservaEstacaoRepository reservaEstacaoRepository) {
        this.estacaoTrabalhoRepository = estacaoTrabalhoRepository;
        this.reservaEstacaoRepository = reservaEstacaoRepository;
    }

    @Transactional(readOnly = true)
    public IndicadorResponse calcularIndiceConforto(Long estacaoId, LocalDateTime inicio, LocalDateTime fim) {
        EstacaoTrabalho estacao = estacaoTrabalhoRepository.findById(estacaoId)
                .orElseThrow(() -> new NotFoundException("Estação não encontrada"));

        var query = entityManager.createNativeQuery("SELECT FNC_CALC_INDICE_CONFORTO(?1, ?2, ?3) FROM dual");
        query.setParameter(1, estacao.getId());
        query.setParameter(2, Timestamp.valueOf(inicio));
        query.setParameter(3, Timestamp.valueOf(fim));
        Object result = query.getSingleResult();
        BigDecimal valor = result == null ? BigDecimal.ZERO : new BigDecimal(result.toString());
        return new IndicadorResponse("indice_conforto", valor);
    }

    @Transactional(readOnly = true)
    public IndicadorResponse calcularTaxaOcupacao(Long estacaoId, LocalDateTime inicio, LocalDateTime fim) {
        EstacaoTrabalho estacao = estacaoTrabalhoRepository.findById(estacaoId)
                .orElseThrow(() -> new NotFoundException("Estação não encontrada"));

        var query = entityManager.createNativeQuery("SELECT FNC_TAXA_OCUPACAO_ESTACAO(?1, ?2, ?3) FROM dual");
        query.setParameter(1, estacao.getId());
        query.setParameter(2, Timestamp.valueOf(inicio));
        query.setParameter(3, Timestamp.valueOf(fim));
        Object result = query.getSingleResult();
        BigDecimal valor = result == null ? BigDecimal.ZERO : new BigDecimal(result.toString());
        return new IndicadorResponse("taxa_ocupacao", valor);
    }

    @Transactional(readOnly = true)
    public CompatibilidadeResponse verificarCompatibilidade(Long reservaId) {
        ReservaEstacao reserva = reservaEstacaoRepository.findById(reservaId)
                .orElseThrow(() -> new NotFoundException("Reserva não encontrada"));

        var query = entityManager.createNativeQuery("SELECT FNC_RESERVA_COMPATIVEL(?1) FROM dual");
        query.setParameter(1, reserva.getId());
        Object result = query.getSingleResult();
        boolean compativel = result != null && "S".equalsIgnoreCase(result.toString());
        String mensagem = compativel ? "Reserva compatível com preferências" : "Reserva não compatível com preferências";
        return new CompatibilidadeResponse(reservaId, compativel, mensagem);
    }
}
