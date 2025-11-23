package br.com.neurosync.api.repository;

import br.com.neurosync.api.entity.EstacaoTrabalho;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface EstacaoTrabalhoRepository extends JpaRepository<EstacaoTrabalho, Long> {

    @Query("""
            select e from EstacaoTrabalho e
            where (:zonaId is null or e.zonaSensorial.id = :zonaId)
              and (:statusEstacao is null or e.statusEstacao = :statusEstacao)
              and (:permiteReserva is null or e.permiteReserva = :permiteReserva)
            """)
    Page<EstacaoTrabalho> buscarComFiltros(@Param("zonaId") Long zonaId,
                                           @Param("statusEstacao") String statusEstacao,
                                           @Param("permiteReserva") String permiteReserva,
                                           Pageable pageable);
}
