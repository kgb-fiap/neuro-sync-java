package br.com.neurosync.api.mapper;

import br.com.neurosync.api.dto.PreferenciaSensorialResponse;
import br.com.neurosync.api.entity.PreferenciaSensorial;

public class PreferenciaSensorialMapper {

    private PreferenciaSensorialMapper() {
    }

    public static PreferenciaSensorialResponse toResponse(PreferenciaSensorial entity) {
        PreferenciaSensorialResponse response = new PreferenciaSensorialResponse();
        response.setId(entity.getId());
        response.setUsuarioId(entity.getUsuario().getId());
        response.setRuidoMaxDb(entity.getRuidoMaxDb());
        response.setLuzMinLux(entity.getLuzMinLux());
        response.setLuzMaxLux(entity.getLuzMaxLux());
        response.setToleranciaVisual(entity.getToleranciaVisual());
        response.setPrefereZona(entity.getPrefereZona());
        response.setObservacoesPreferencia(entity.getObservacoesPreferencia());
        response.setDataInicioVigencia(entity.getDataInicioVigencia());
        response.setDataFimVigencia(entity.getDataFimVigencia());
        response.setAtivo(entity.getAtivo());
        return response;
    }
}
