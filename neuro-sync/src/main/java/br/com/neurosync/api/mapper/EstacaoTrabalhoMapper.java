package br.com.neurosync.api.mapper;

import br.com.neurosync.api.dto.EstacaoTrabalhoResponse;
import br.com.neurosync.api.entity.EstacaoTrabalho;

public class EstacaoTrabalhoMapper {

    private EstacaoTrabalhoMapper() {
    }

    public static EstacaoTrabalhoResponse toResponse(EstacaoTrabalho estacao) {
        EstacaoTrabalhoResponse response = new EstacaoTrabalhoResponse();
        response.setId(estacao.getId());
        response.setCodigoEstacao(estacao.getCodigoEstacao());
        response.setDescricao(estacao.getDescricao());
        response.setPermiteReserva(estacao.getPermiteReserva());
        response.setPermiteUsoEspontaneo(estacao.getPermiteUsoEspontaneo());
        response.setStatusEstacao(estacao.getStatusEstacao());
        response.setObservacoes(estacao.getObservacoes());
        response.setDataCadastro(estacao.getDataCadastro());
        if (estacao.getZonaSensorial() != null) {
            response.setZonaSensorialId(estacao.getZonaSensorial().getId());
            response.setZonaSensorialNome(estacao.getZonaSensorial().getNomeZona());
        }
        return response;
    }
}
