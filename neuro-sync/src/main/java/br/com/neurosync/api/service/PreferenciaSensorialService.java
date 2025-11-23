package br.com.neurosync.api.service;

import br.com.neurosync.api.dto.PreferenciaSensorialRequest;
import br.com.neurosync.api.dto.PreferenciaSensorialResponse;
import br.com.neurosync.api.entity.PreferenciaSensorial;
import br.com.neurosync.api.entity.Usuario;
import br.com.neurosync.api.exception.NotFoundException;
import br.com.neurosync.api.mapper.PreferenciaSensorialMapper;
import br.com.neurosync.api.repository.PreferenciaSensorialRepository;
import br.com.neurosync.api.repository.UsuarioRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PreferenciaSensorialService {

    private final PreferenciaSensorialRepository preferenciaSensorialRepository;
    private final UsuarioRepository usuarioRepository;

    public PreferenciaSensorialService(PreferenciaSensorialRepository preferenciaSensorialRepository, UsuarioRepository usuarioRepository) {
        this.preferenciaSensorialRepository = preferenciaSensorialRepository;
        this.usuarioRepository = usuarioRepository;
    }

    @Transactional
    public PreferenciaSensorialResponse criar(PreferenciaSensorialRequest request) {
        Usuario usuario = usuarioRepository.findById(request.getUsuarioId())
                .orElseThrow(() -> new NotFoundException("Usuário não encontrado"));

        PreferenciaSensorial preferencia = new PreferenciaSensorial();
        preferencia.setUsuario(usuario);
        preferencia.setRuidoMaxDb(request.getRuidoMaxDb());
        preferencia.setLuzMinLux(request.getLuzMinLux());
        preferencia.setLuzMaxLux(request.getLuzMaxLux());
        preferencia.setToleranciaVisual(request.getToleranciaVisual());
        preferencia.setPrefereZona(request.getPrefereZona());
        preferencia.setObservacoesPreferencia(request.getObservacoesPreferencia());
        preferencia.setDataInicioVigencia(request.getDataInicioVigencia());
        preferencia.setDataFimVigencia(request.getDataFimVigencia());
        preferencia.setAtivo(request.getAtivo() != null ? request.getAtivo() : "S");

        PreferenciaSensorial salva = preferenciaSensorialRepository.save(preferencia);
        return PreferenciaSensorialMapper.toResponse(salva);
    }

    @Transactional(readOnly = true)
    public List<PreferenciaSensorialResponse> buscarPorUsuario(Long usuarioId) {
        return preferenciaSensorialRepository.findByUsuarioId(usuarioId)
                .stream()
                .map(PreferenciaSensorialMapper::toResponse)
                .toList();
    }
}
