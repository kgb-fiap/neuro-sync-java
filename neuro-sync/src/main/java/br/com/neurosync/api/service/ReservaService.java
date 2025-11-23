package br.com.neurosync.api.service;

import br.com.neurosync.api.dto.AvaliacaoRequest;
import br.com.neurosync.api.dto.AvaliacaoResponse;
import br.com.neurosync.api.dto.ReservaRequest;
import br.com.neurosync.api.dto.ReservaResponse;
import br.com.neurosync.api.entity.AvaliacaoEstacao;
import br.com.neurosync.api.entity.EstacaoTrabalho;
import br.com.neurosync.api.entity.ReservaEstacao;
import br.com.neurosync.api.entity.StatusReserva;
import br.com.neurosync.api.entity.Usuario;
import br.com.neurosync.api.exception.NotFoundException;
import br.com.neurosync.api.mapper.AvaliacaoMapper;
import br.com.neurosync.api.mapper.ReservaMapper;
import br.com.neurosync.api.repository.AvaliacaoEstacaoRepository;
import br.com.neurosync.api.repository.EstacaoTrabalhoRepository;
import br.com.neurosync.api.repository.ReservaEstacaoRepository;
import br.com.neurosync.api.repository.StatusReservaRepository;
import br.com.neurosync.api.repository.UsuarioRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@Service
public class ReservaService {

    private final ReservaEstacaoRepository reservaEstacaoRepository;
    private final UsuarioRepository usuarioRepository;
    private final EstacaoTrabalhoRepository estacaoTrabalhoRepository;
    private final StatusReservaRepository statusReservaRepository;
    private final AvaliacaoEstacaoRepository avaliacaoEstacaoRepository;

    @PersistenceContext
    private EntityManager entityManager;

    public ReservaService(ReservaEstacaoRepository reservaEstacaoRepository,
                          UsuarioRepository usuarioRepository,
                          EstacaoTrabalhoRepository estacaoTrabalhoRepository,
                          StatusReservaRepository statusReservaRepository,
                          AvaliacaoEstacaoRepository avaliacaoEstacaoRepository) {
        this.reservaEstacaoRepository = reservaEstacaoRepository;
        this.usuarioRepository = usuarioRepository;
        this.estacaoTrabalhoRepository = estacaoTrabalhoRepository;
        this.statusReservaRepository = statusReservaRepository;
        this.avaliacaoEstacaoRepository = avaliacaoEstacaoRepository;
    }

    @Transactional(readOnly = true)
    public Page<ReservaResponse> listar(Long usuarioId, Long statusId, LocalDateTime inicio, LocalDateTime fim, Pageable pageable) {
        return reservaEstacaoRepository.buscarComFiltros(usuarioId, statusId, inicio, fim, pageable)
                .map(ReservaMapper::toResponse);
    }

    @Transactional
    public ReservaResponse criarComProcedure(ReservaRequest request) {
        Usuario usuario = usuarioRepository.findById(request.getUsuarioId())
                .orElseThrow(() -> new NotFoundException("Usuário não encontrado"));
        EstacaoTrabalho estacao = estacaoTrabalhoRepository.findById(request.getEstacaoId())
                .orElseThrow(() -> new NotFoundException("Estação não encontrada"));
        StatusReserva statusReserva = statusReservaRepository.findById(request.getStatusReservaId())
                .orElseThrow(() -> new NotFoundException("Status de reserva não encontrado"));

        StoredProcedureQuery sp = entityManager.createStoredProcedureQuery("PRC_INS_RESERVA_ESTACAO");
        sp.registerStoredProcedureParameter("p_id_usuario", Long.class, ParameterMode.IN);
        sp.registerStoredProcedureParameter("p_id_estacao", Long.class, ParameterMode.IN);
        sp.registerStoredProcedureParameter("p_id_status_reserva", Long.class, ParameterMode.IN);
        sp.registerStoredProcedureParameter("p_data_hora_inicio_prevista", java.sql.Timestamp.class, ParameterMode.IN);
        sp.registerStoredProcedureParameter("p_data_hora_fim_prevista", java.sql.Timestamp.class, ParameterMode.IN);
        sp.registerStoredProcedureParameter("p_origem_reserva", String.class, ParameterMode.IN);
        sp.registerStoredProcedureParameter("p_motivo_cancelamento", String.class, ParameterMode.IN);
        sp.registerStoredProcedureParameter("p_indice_conforto_calculado", Double.class, ParameterMode.IN);
        sp.registerStoredProcedureParameter("p_observacoes", String.class, ParameterMode.IN);
        sp.registerStoredProcedureParameter("p_id_reserva_out", Long.class, ParameterMode.OUT);

        sp.setParameter("p_id_usuario", usuario.getId());
        sp.setParameter("p_id_estacao", estacao.getId());
        sp.setParameter("p_id_status_reserva", statusReserva.getId());
        sp.setParameter("p_data_hora_inicio_prevista", Timestamp.valueOf(request.getDataHoraInicioPrevista()));
        sp.setParameter("p_data_hora_fim_prevista", Timestamp.valueOf(request.getDataHoraFimPrevista()));
        sp.setParameter("p_origem_reserva", request.getOrigemReserva());
        sp.setParameter("p_motivo_cancelamento", null);
        sp.setParameter("p_indice_conforto_calculado", null);
        sp.setParameter("p_observacoes", request.getObservacoes());
        sp.execute();

        Long idReserva = null;
        Object out = sp.getOutputParameterValue("p_id_reserva_out");
        if (out instanceof Number number) {
            idReserva = number.longValue();
        }

        ReservaEstacao reservaPersistida = idReserva != null
                ? reservaEstacaoRepository.findById(idReserva)
                .orElse(null)
                : null;

        if (reservaPersistida == null) {
            ReservaEstacao reserva = new ReservaEstacao();
            reserva.setUsuario(usuario);
            reserva.setEstacaoTrabalho(estacao);
            reserva.setStatusReserva(statusReserva);
            reserva.setDataHoraSolicitacao(LocalDateTime.now());
            reserva.setDataHoraInicioPrevista(request.getDataHoraInicioPrevista());
            reserva.setDataHoraFimPrevista(request.getDataHoraFimPrevista());
            reserva.setOrigemReserva(request.getOrigemReserva());
            reserva.setObservacoes(request.getObservacoes());
            reservaPersistida = reservaEstacaoRepository.save(reserva);
        }

        return ReservaMapper.toResponse(reservaPersistida);
    }

    @Transactional
    public AvaliacaoResponse criarAvaliacaoComProcedure(AvaliacaoRequest request) {
        ReservaEstacao reserva = reservaEstacaoRepository.findById(request.getReservaId())
                .orElseThrow(() -> new NotFoundException("Reserva não encontrada"));

        StoredProcedureQuery sp = entityManager.createStoredProcedureQuery("PRC_INS_AVALIACAO_ESTACAO");
        sp.registerStoredProcedureParameter("p_id_reserva", Long.class, ParameterMode.IN);
        sp.registerStoredProcedureParameter("p_nota_conforto_geral", Integer.class, ParameterMode.IN);
        sp.registerStoredProcedureParameter("p_nota_ruido", Integer.class, ParameterMode.IN);
        sp.registerStoredProcedureParameter("p_nota_luz", Integer.class, ParameterMode.IN);
        sp.registerStoredProcedureParameter("p_nota_visual", Integer.class, ParameterMode.IN);
        sp.registerStoredProcedureParameter("p_comentario", String.class, ParameterMode.IN);
        sp.registerStoredProcedureParameter("p_id_avaliacao_out", Long.class, ParameterMode.OUT);

        sp.setParameter("p_id_reserva", reserva.getId());
        sp.setParameter("p_nota_conforto_geral", request.getNotaConfortoGeral());
        sp.setParameter("p_nota_ruido", request.getNotaRuido());
        sp.setParameter("p_nota_luz", request.getNotaLuz());
        sp.setParameter("p_nota_visual", request.getNotaEstimuloVisual());
        sp.setParameter("p_comentario", request.getComentario());
        sp.execute();

        Long idAvaliacao = null;
        Object out = sp.getOutputParameterValue("p_id_avaliacao_out");
        if (out instanceof Number number) {
            idAvaliacao = number.longValue();
        }

        AvaliacaoEstacao avaliacao = idAvaliacao != null
                ? avaliacaoEstacaoRepository.findById(idAvaliacao).orElse(null)
                : null;

        if (avaliacao == null) {
            avaliacao = new AvaliacaoEstacao();
            avaliacao.setReservaEstacao(reserva);
            avaliacao.setNotaConfortoGeral(request.getNotaConfortoGeral());
            avaliacao.setNotaRuido(request.getNotaRuido());
            avaliacao.setNotaLuz(request.getNotaLuz());
            avaliacao.setNotaEstimuloVisual(request.getNotaEstimuloVisual());
            avaliacao.setComentario(request.getComentario());
            avaliacao.setDataAvaliacao(LocalDateTime.now());
            avaliacao = avaliacaoEstacaoRepository.save(avaliacao);
        }

        return AvaliacaoMapper.toResponse(avaliacao);
    }

    @Transactional(readOnly = true)
    public ReservaEstacao buscarEntidade(Long id) {
        return reservaEstacaoRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Reserva não encontrada"));
    }
}
