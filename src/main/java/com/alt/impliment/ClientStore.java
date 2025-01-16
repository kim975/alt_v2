package com.alt.impliment;

import com.alt.domain.ClientAuthVO;
import com.alt.domain.ClientVO;
import com.alt.mapper.ClientMapper;
import java.util.regex.Pattern;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

@Component
@AllArgsConstructor
public class ClientStore {

    private final ClientMapper clientMapper;

    public void register(ClientVO clientVO) {

        validationRegister(clientVO);

        clientMapper.register(clientVO);

        ClientAuthVO clientAuthVO = new ClientAuthVO();
        clientAuthVO.setCid(clientVO.getCid());
        clientMapper.roleRegister(clientAuthVO);
    }

    private void validationRegister(ClientVO clientVO) {
        if (StringUtils.isEmpty(clientVO.getCid())) {
            throw new IllegalArgumentException();
        }

        if (clientVO.getCid().length() < 5) {
            throw new IllegalArgumentException();
        }

        if (clientVO.getCid().length() > 10) {
            throw new IllegalArgumentException();
        }

        Pattern pattern = Pattern.compile("^(01[016789])-(\\d{3,4})-(\\d{4})$");

        if (!pattern.matcher(clientVO.getCphone()).matches()) {
            throw new IllegalArgumentException();
        }
        int phoneNumberLength = clientVO.getCphone().replace("-", "").length();

        if (phoneNumberLength < 10 || phoneNumberLength > 11) {
            throw new IllegalArgumentException();
        }

        if (StringUtils.isEmpty(clientVO.getCnick())) {
            throw new IllegalArgumentException();
        }

        if (clientVO.getCnick().length() < 2) {
            throw new IllegalArgumentException();
        }

        if (clientVO.getCnick().length() > 15) {
            throw new IllegalArgumentException();
        }
    }

}
