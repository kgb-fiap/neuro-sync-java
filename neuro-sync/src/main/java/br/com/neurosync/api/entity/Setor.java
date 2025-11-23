package br.com.neurosync.api.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "SETOR")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Setor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_SETOR")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ID_FILIAL", nullable = false)
    private Filial filial;

    @Column(name = "NOME_SETOR", nullable = false)
    private String nomeSetor;

    @Column(name = "CODIGO_SETOR")
    private String codigoSetor;

    @Column(name = "ANDAR")
    private String andar;

    @Column(name = "DESCRICAO")
    private String descricao;

    @Column(name = "DATA_CADASTRO")
    private LocalDateTime dataCadastro;

    @Column(name = "STATUS_ATIVO")
    private String statusAtivo;

    @OneToMany(mappedBy = "setor", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<Usuario> usuarios;
}
