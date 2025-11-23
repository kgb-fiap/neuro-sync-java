package br.com.neurosync.api.mapper;

import br.com.neurosync.api.dto.AvaliacaoResponse;
import br.com.neurosync.api.entity.AvaliacaoEstacao;

public class AvaliacaoMapper {
    private AvaliacaoMapper() {
    }

    public static AvaliacaoResponse toResponse(AvaliacaoEstacao avaliacao) {
        AvaliacaoResponse response = new AvaliacaoResponse();
        response.setId(avaliacao.getId());
        response.setReservaId(avaliacao.getReservaEstacao().getId());
        response.setNotaConfortoGeral(avaliacao.getNotaConfortoGeral());
        response.setNotaRuido(avaliacao.getNotaRuido());
        response.setNotaLuz(avaliacao.getNotaLuz());
        response.setNotaEstimuloVisual(avaliacao.getNotaEstimuloVisual());
        response.setComentario(avaliacao.getComentario());
        response.setDataAvaliacao(avaliacao.getDataAvaliacao());
        return response;
    }
}
