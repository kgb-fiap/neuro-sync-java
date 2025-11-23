package br.com.neurosync.api.repository;

import br.com.neurosync.api.entity.Sensor;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SensorRepository extends JpaRepository<Sensor, Long> {
}
