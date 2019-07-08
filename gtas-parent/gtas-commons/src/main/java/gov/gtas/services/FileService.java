/*
 * All GTAS code is Copyright 2016, The Department of Homeland Security (DHS), U.S. Customs and Border Protection (CBP).
 * 
 * Please see LICENSE.txt for details.
 */
package gov.gtas.services;
import java.io.File;

import org.springframework.security.access.prepost.PreAuthorize;
import static gov.gtas.constant.GtasSecurityConstants.PRIVILEGE_ADMIN;

public interface FileService {
  @PreAuthorize(PRIVILEGE_ADMIN)
  public String[] getLogTypeList();

  @PreAuthorize(PRIVILEGE_ADMIN)
  public String[][] getLogZipList(String logType);

  @PreAuthorize(PRIVILEGE_ADMIN)
  public byte[] getLogZip(String logType, String logFile);

  @PreAuthorize(PRIVILEGE_ADMIN)
  public File getLogZip2(String logType, String logFile);

  }
