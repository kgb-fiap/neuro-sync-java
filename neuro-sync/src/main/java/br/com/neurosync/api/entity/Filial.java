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
@Table(name = "FILIAL")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Filial {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_FILIAL")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ID_EMPRESA", nullable = false)
    private Empresa empresa;

    @Column(name = "NOME_FILIAL", nullable = false)
    private String nomeFilial;

    @Column(name = "CODIGO_FILIAL")
    private String codigoFilial;

    @Column(name = "CIDADE")
    private String cidade;

    @Column(name = "UF")
    private String uf;

    @Column(name = "PAIS")
    private String pais;

    @Column(name = "ENDERECO")
    private String endereco;

    @Column(name = "DATA_CADASTRO")
    private LocalDateTime dataCadastro;

    @Column(name = "STATUS_ATIVO")
    private String statusAtivo;

    @OneToMany(mappedBy = "filial", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<Setor> setores;

    @OneToMany(mappedBy = "filial", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<ZonaSensorial> zonasSensorial;
}
