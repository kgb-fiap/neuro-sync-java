package br.com.neurosync.api.repository;

import br.com.neurosync.api.entity.UsuarioPerfil;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsuarioPerfilRepository extends JpaRepository<UsuarioPerfil, Long> {
}
