package br.com.neurosync.api.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "USUARIO_PERFIL")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UsuarioPerfil {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_USUARIO_PERFIL")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ID_USUARIO", nullable = false)
    private Usuario usuario;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ID_PERFIL", nullable = false)
    private Perfil perfil;

    @Column(name = "DATA_ATRIBUICAO")
    private LocalDateTime dataAtribuicao;

    @Column(name = "USUARIO_RESPONSAVEL")
    private String usuarioResponsavel;

    @Column(name = "STATUS_ATIVO")
    private String statusAtivo;
}
