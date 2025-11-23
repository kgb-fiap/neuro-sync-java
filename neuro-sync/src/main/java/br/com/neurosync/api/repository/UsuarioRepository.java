package br.com.neurosync.api.repository;

import br.com.neurosync.api.entity.Usuario;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UsuarioRepository extends JpaRepository<Usuario, Long> {

    @EntityGraph(attributePaths = {"perfis", "perfis.perfil"})
    Optional<Usuario> findByEmailCorporativo(String emailCorporativo);
}
