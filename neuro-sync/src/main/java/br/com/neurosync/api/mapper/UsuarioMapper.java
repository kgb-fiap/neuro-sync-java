package br.com.neurosync.api.mapper;

import br.com.neurosync.api.dto.UsuarioResponse;
import br.com.neurosync.api.entity.Usuario;
import br.com.neurosync.api.entity.UsuarioPerfil;

import java.util.List;
import java.util.stream.Collectors;

public class UsuarioMapper {

    private UsuarioMapper() {
    }

    public static UsuarioResponse toResponse(Usuario usuario) {
        UsuarioResponse response = new UsuarioResponse();
        response.setId(usuario.getId());
        response.setNomeCompleto(usuario.getNomeCompleto());
        response.setEmailCorporativo(usuario.getEmailCorporativo());
        response.setTelefone(usuario.getTelefone());
        response.setStatusAtivo(usuario.getStatusAtivo());
        response.setFlagNeurodivergente(usuario.getFlagNeurodivergente());
        if (usuario.getSetor() != null) {
            response.setSetorId(usuario.getSetor().getId());
            response.setSetorNome(usuario.getSetor().getNomeSetor());
        }
        List<String> perfis = usuario.getPerfis() == null ? List.of() :
                usuario.getPerfis()
                        .stream()
                        .map(UsuarioPerfil::getPerfil)
                        .map(p -> p.getNomePerfil())
                        .collect(Collectors.toList());
        response.setPerfis(perfis);
        return response;
    }
}
