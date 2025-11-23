package br.com.neurosync.api.repository;

import br.com.neurosync.api.entity.PreferenciaSensorial;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PreferenciaSensorialRepository extends JpaRepository<PreferenciaSensorial, Long> {
    List<PreferenciaSensorial> findByUsuarioId(Long usuarioId);
}
