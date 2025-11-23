package br.com.neurosync.api.repository;

import br.com.neurosync.api.entity.ReservaEstacao;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;

public interface ReservaEstacaoRepository extends JpaRepository<ReservaEstacao, Long> {

    @Query("""
            select r from ReservaEstacao r
            where (:usuarioId is null or r.usuario.id = :usuarioId)
              and (:statusId is null or r.statusReserva.id = :statusId)
              and (:inicio is null or r.dataHoraInicioPrevista >= :inicio)
              and (:fim is null or r.dataHoraFimPrevista <= :fim)
            """)
    Page<ReservaEstacao> buscarComFiltros(@Param("usuarioId") Long usuarioId,
                                          @Param("statusId") Long statusId,
                                          @Param("inicio") LocalDateTime inicio,
                                          @Param("fim") LocalDateTime fim,
                                          Pageable pageable);
}
