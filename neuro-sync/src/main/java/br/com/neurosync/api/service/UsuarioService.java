package br.com.neurosync.api.service;

import br.com.neurosync.api.dto.UsuarioRequest;
import br.com.neurosync.api.dto.UsuarioResponse;
import br.com.neurosync.api.entity.Perfil;
import br.com.neurosync.api.entity.Setor;
import br.com.neurosync.api.entity.Usuario;
import br.com.neurosync.api.entity.UsuarioPerfil;
import br.com.neurosync.api.exception.BusinessException;
import br.com.neurosync.api.exception.NotFoundException;
import br.com.neurosync.api.mapper.UsuarioMapper;
import br.com.neurosync.api.repository.PerfilRepository;
import br.com.neurosync.api.repository.SetorRepository;
import br.com.neurosync.api.repository.UsuarioPerfilRepository;
import br.com.neurosync.api.repository.UsuarioRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class UsuarioService {

    private final UsuarioRepository usuarioRepository;
    private final SetorRepository setorRepository;
    private final PerfilRepository perfilRepository;
    private final UsuarioPerfilRepository usuarioPerfilRepository;
    private final PasswordEncoder passwordEncoder;

    public UsuarioService(UsuarioRepository usuarioRepository,
                          SetorRepository setorRepository,
                          PerfilRepository perfilRepository,
                          UsuarioPerfilRepository usuarioPerfilRepository,
                          PasswordEncoder passwordEncoder) {
        this.usuarioRepository = usuarioRepository;
        this.setorRepository = setorRepository;
        this.perfilRepository = perfilRepository;
        this.usuarioPerfilRepository = usuarioPerfilRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Transactional(readOnly = true)
    public List<UsuarioResponse> listar() {
        return usuarioRepository.findAll()
                .stream()
                .map(UsuarioMapper::toResponse)
                .toList();
    }

    @Transactional(readOnly = true)
    public UsuarioResponse buscarPorId(Long id) {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Usuário não encontrado"));
        return UsuarioMapper.toResponse(usuario);
    }

    @Transactional
    public UsuarioResponse criar(UsuarioRequest request) {
        usuarioRepository.findByEmailCorporativo(request.getEmailCorporativo())
                .ifPresent(u -> {
                    throw new BusinessException("Email corporativo já cadastrado");
                });

        Setor setor = setorRepository.findById(request.getSetorId())
                .orElseThrow(() -> new NotFoundException("Setor não encontrado"));

        Usuario usuario = new Usuario();
        usuario.setSetor(setor);
        usuario.setNomeCompleto(request.getNomeCompleto());
        usuario.setEmailCorporativo(request.getEmailCorporativo());
        usuario.setSenhaHash(passwordEncoder.encode(request.getSenha()));
        usuario.setMatriculaInterna(request.getMatriculaInterna());
        usuario.setTelefone(request.getTelefone());
        usuario.setDataAdmissao(request.getDataAdmissao());
        usuario.setDataCadastro(LocalDateTime.now());
        usuario.setStatusAtivo("S");
        usuario.setFlagNeurodivergente(request.getFlagNeurodivergente() != null ? request.getFlagNeurodivergente() : "N");
        usuario.setObservacoesSuporte(null);
        usuario.setQuantidadeTentativasLogin(0);
        usuario.setMudarSenhaProximoLogin("N");

        usuario.setPerfis(new ArrayList<>());
        Usuario salvo = usuarioRepository.save(usuario);

        if (request.getPerfisIds() != null) {
            for (Long idPerfil : request.getPerfisIds()) {
                Perfil perfil = perfilRepository.findById(idPerfil)
                        .orElseThrow(() -> new NotFoundException("Perfil não encontrado"));
                UsuarioPerfil up = new UsuarioPerfil();
                up.setUsuario(salvo);
                up.setPerfil(perfil);
                up.setDataAtribuicao(LocalDateTime.now());
                up.setStatusAtivo("S");
                usuarioPerfilRepository.save(up);
                salvo.getPerfis().add(up);
            }
        }

        return UsuarioMapper.toResponse(salvo);
    }
}
