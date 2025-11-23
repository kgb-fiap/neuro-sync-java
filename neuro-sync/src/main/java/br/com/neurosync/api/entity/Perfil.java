package br.com.neurosync.api.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Entity
@Table(name = "PERFIL")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Perfil {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_PERFIL")
    private Long id;

    @Column(name = "NOME_PERFIL", nullable = false)
    private String nomePerfil;

    @Column(name = "DESCRICAO")
    private String descricao;

    @Column(name = "NIVEL_ACESSO")
    private Integer nivelAcesso;

    @Column(name = "STATUS_ATIVO")
    private String statusAtivo;

    @OneToMany(mappedBy = "perfil", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<UsuarioPerfil> usuarios;
}
