package br.com.neurosync.api.mapper;

import br.com.neurosync.api.dto.ZonaSensorialResponse;
import br.com.neurosync.api.entity.ZonaSensorial;

public class ZonaSensorialMapper {
    private ZonaSensorialMapper() {
    }

    public static ZonaSensorialResponse toResponse(ZonaSensorial zona) {
        ZonaSensorialResponse response = new ZonaSensorialResponse();
        response.setId(zona.getId());
        response.setNomeZona(zona.getNomeZona());
        response.setTipoZona(zona.getTipoZona());
        response.setStatusAtivo(zona.getStatusAtivo());
        if (zona.getFilial() != null) {
            response.setFilialId(zona.getFilial().getId());
            response.setFilialNome(zona.getFilial().getNomeFilial());
        }
        return response;
    }
}
