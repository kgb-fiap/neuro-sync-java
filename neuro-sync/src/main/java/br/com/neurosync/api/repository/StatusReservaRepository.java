package br.com.neurosync.api.repository;

import br.com.neurosync.api.entity.StatusReserva;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StatusReservaRepository extends JpaRepository<StatusReserva, Long> {
}
