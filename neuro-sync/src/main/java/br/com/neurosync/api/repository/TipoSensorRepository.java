package br.com.neurosync.api.repository;

import br.com.neurosync.api.entity.TipoSensor;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TipoSensorRepository extends JpaRepository<TipoSensor, Long> {
}
