package com.shopping.service;

import com.paging.CommonParams;
import com.paging.Pagination;
import com.shopping.domain.Board;
import com.shopping.domain.BoardRepository;
import com.shopping.dto.BoardRequestDto;
import com.shopping.dto.BoardResponseDto;
import com.exception.CustomException;
import com.exception.ErrorCode;
import com.shopping.mapper.BoardMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BoardService {

    private final BoardRepository boardRepository;
    private final BoardMapper boardMapper;

    /**
     * 게시글 저장
     */
    @Transactional
    public Long save(final BoardRequestDto params) {

        Board entity = boardRepository.save(params.toEntity());
        return entity.getId();
    }

    /**
     * 게시글 삭제
     */
    @Transactional
    public Long delete(final Long id) {
        Board entity = boardRepository.findById(id).orElseThrow(() -> new CustomException(ErrorCode.POSTS_NOT_FOUND));
        entity.delete();
        return id;
    }


//    /**
//     * 게시글 조회 - 삭제여부 N(현재는 안씀 mybatis + jpa)
//     */
//    public List<BoardResponseDto> findAllByDeleteYn(char deleteYn) {
//        Sort sort = Sort.by(Sort.Direction.DESC, "id", "createdDate");
//        List<Board> list = boardRepository.findAllByDeleteYn(deleteYn, sort);
//        return list.stream().map(BoardResponseDto :: new).collect(Collectors.toList());
//    }

    /**
     * 게시글 조회 - mybatis
     */
    public Map<String, Object> findAll(CommonParams params) {
        // 게시글 수 조회
        int count = boardMapper.count(params);

        if (count < 1) {
            return Collections.emptyMap();
        }

        // 페이지네이션 정보 계산
        Pagination pagination = new Pagination(count, params);
        params.setPagination(pagination);

        // 게시글 리스트 조회
        List<BoardResponseDto> list = boardMapper.findAll(params);

        Map<String, Object> response = new HashMap<>();
        response.put("params", params);
        response.put("list", list);

        return response;
    }

    /**
     * 게시글 수정
     */
    @Transactional
    public Long update(final Long id, final BoardRequestDto params) {

        Board entity = boardRepository.findById(id).orElseThrow(() -> new CustomException(ErrorCode.POSTS_NOT_FOUND));

        entity.update(params.getTitle(), params.getPrice() ,params.getContent(), params.getUseyn());
        return id;
    }

    /**
     * 상세보기
     */
    @Transactional
    public BoardResponseDto findById(final Long id) {
        Board entity = boardRepository.findById(id).orElseThrow(() -> new CustomException(ErrorCode.POSTS_NOT_FOUND));

        entity.hitsup();
        return new BoardResponseDto(entity);
    }
}
