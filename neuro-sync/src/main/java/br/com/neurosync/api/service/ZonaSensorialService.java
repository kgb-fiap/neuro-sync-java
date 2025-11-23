package br.com.neurosync.api.service;

import br.com.neurosync.api.dto.ZonaSensorialResponse;
import br.com.neurosync.api.entity.ZonaSensorial;
import br.com.neurosync.api.exception.NotFoundException;
import br.com.neurosync.api.mapper.ZonaSensorialMapper;
import br.com.neurosync.api.repository.ZonaSensorialRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ZonaSensorialService {

    private final ZonaSensorialRepository zonaSensorialRepository;

    public ZonaSensorialService(ZonaSensorialRepository zonaSensorialRepository) {
        this.zonaSensorialRepository = zonaSensorialRepository;
    }

    @Transactional(readOnly = true)
    public List<ZonaSensorialResponse> listar() {
        return zonaSensorialRepository.findAll()
                .stream()
                .map(ZonaSensorialMapper::toResponse)
                .toList();
    }

    @Transactional(readOnly = true)
    public ZonaSensorial buscarEntidade(Long id) {
        return zonaSensorialRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Zona sensorial não encontrada"));
    }
}
