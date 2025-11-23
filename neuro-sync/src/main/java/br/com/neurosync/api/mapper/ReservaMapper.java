package br.com.neurosync.api.mapper;

import br.com.neurosync.api.dto.ReservaResponse;
import br.com.neurosync.api.entity.ReservaEstacao;

public class ReservaMapper {

    private ReservaMapper() {
    }

    public static ReservaResponse toResponse(ReservaEstacao reserva) {
        ReservaResponse response = new ReservaResponse();
        response.setId(reserva.getId());
        response.setUsuarioId(reserva.getUsuario().getId());
        response.setUsuarioNome(reserva.getUsuario().getNomeCompleto());
        response.setEstacaoId(reserva.getEstacaoTrabalho().getId());
        response.setCodigoEstacao(reserva.getEstacaoTrabalho().getCodigoEstacao());
        response.setStatusReservaId(reserva.getStatusReserva().getId());
        response.setStatusCodigo(reserva.getStatusReserva().getCodigoStatus());
        response.setDataHoraSolicitacao(reserva.getDataHoraSolicitacao());
        response.setDataHoraInicioPrevista(reserva.getDataHoraInicioPrevista());
        response.setDataHoraFimPrevista(reserva.getDataHoraFimPrevista());
        response.setDataHoraCheckin(reserva.getDataHoraCheckin());
        response.setDataHoraCheckout(reserva.getDataHoraCheckout());
        response.setOrigemReserva(reserva.getOrigemReserva());
        response.setMotivoCancelamento(reserva.getMotivoCancelamento());
        response.setIndiceConfortoCalculado(reserva.getIndiceConfortoCalculado());
        response.setObservacoes(reserva.getObservacoes());
        return response;
    }
}
