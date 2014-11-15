*=======================================================================
*
* WCSLIB 4.19 - an implementation of the FITS WCS standard.
* Copyright (C) 1995-2013, Mark Calabretta
*
* This file is part of WCSLIB.
*
* WCSLIB is free software: you can redistribute it and/or modify it
* under the terms of the GNU Lesser General Public License as published
* by the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* WCSLIB is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
* FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
* License for more details.
*
* You should have received a copy of the GNU Lesser General Public
* License along with WCSLIB.  If not, see http://www.gnu.org/licenses.
*
* Direct correspondence concerning WCSLIB to mark@calabretta.id.au
*
* Author: Mark Calabretta, Australia Telescope National Facility, CSIRO.
* http://www.atnf.csiro.au/people/Mark.Calabretta
* $Id: tprj1.f,v 4.19 2013/09/29 14:17:53 mcalabre Exp $
*=======================================================================

      PROGRAM TPRJ1
*-----------------------------------------------------------------------
*
* TPRJ1 tests forward and reverse spherical projections for closure.
*
*-----------------------------------------------------------------------
      INCLUDE 'prj.inc'

      INTEGER   J, K, NFAIL, PROJEX, STATUS
      DOUBLE PRECISION PV(0:29)

      DOUBLE PRECISION PI
      PARAMETER (PI = 3.141592653589793238462643D0)

      DOUBLE PRECISION TOL
      PARAMETER (TOL = 1D-9)
*-----------------------------------------------------------------------
      WRITE (*, 10)
 10   FORMAT ('Testing closure of WCSLIB spherical projection ',
     :        'routines (tprj1.f)',/,
     :        '-----------------------------------------------',
     :        '------------------')

      WRITE (*, '(/,A)') 'List of prj status return values:'
      DO 40 STATUS = 1, 4
        DO 30 K = 80, 1, -1
          IF (PRJ_ERRMSG(STATUS)(K:K).NE.' ') THEN
            WRITE(*, 20) STATUS, PRJ_ERRMSG(STATUS)(:K)
 20         FORMAT(I4,': ',A,'.')
            GO TO 40
          END IF
 30     CONTINUE
 40   CONTINUE
      WRITE(*, '()')

      DO 50 J = 0, 29
        PV(J) = 0D0
 50   CONTINUE

      NFAIL = 0

*     AZP: zenithal/azimuthal perspective.
      PV(1) = 0.5D0
      PV(2) =  30D0
      NFAIL = NFAIL + PROJEX ('AZP', PV, 90,   5, TOL)

*     SZP: slant zenithal perspective.
      PV(1) = 0.5D0
      PV(2) = 210D0
      PV(3) =  60D0
      NFAIL = NFAIL + PROJEX ('SZP', PV, 90, -90, TOL)

*     TAN: gnomonic.
      NFAIL = NFAIL + PROJEX ('TAN', PV, 90,   5, TOL)

*     STG: stereographic.
      NFAIL = NFAIL + PROJEX ('STG', PV, 90, -85, TOL)

*     SIN: orthographic/synthesis.
      PV(1) = -0.3D0
      PV(2) =  0.5D0
      NFAIL = NFAIL + PROJEX ('SIN', PV, 90,  45, TOL)

*     ARC: zenithal/azimuthal equidistant.
      NFAIL = NFAIL + PROJEX ('ARC', PV, 90, -90, TOL)

*     ZPN: zenithal/azimuthal polynomial.
      PV(0) =  0.00000D0
      PV(1) =  0.95000D0
      PV(2) = -0.02500D0
      PV(3) = -0.15833D0
      PV(4) =  0.00208D0
      PV(5) =  0.00792D0
      PV(6) = -0.00007D0
      PV(7) = -0.00019D0
      PV(8) =  0.00000D0
      PV(9) =  0.00000D0
      NFAIL = NFAIL + PROJEX ('ZPN', PV, 90,  10, TOL)

*     ZEA: zenithal/azimuthal equal area.
      NFAIL = NFAIL + PROJEX ('ZEA', PV, 90, -85, TOL)

*     AIR: Airy's zenithal projection.
      PV(1) = 45D0
      NFAIL = NFAIL + PROJEX ('AIR', PV, 90, -85, TOL)

*     CYP: cylindrical perspective.
      PV(1) = 3.0D0
      PV(2) = 0.8D0
      NFAIL = NFAIL + PROJEX ('CYP', PV, 90, -90, TOL)

*     CEA: cylindrical equal area.
      PV(1) = 0.75D0
      NFAIL = NFAIL + PROJEX ('CEA', PV, 90, -90, TOL)

*     CAR: plate carree.
      NFAIL = NFAIL + PROJEX ('CAR', PV, 90, -90, TOL)

*     MER: Mercator's.
      NFAIL = NFAIL + PROJEX ('MER', PV, 85, -85, TOL)

*     SFL: Sanson-Flamsteed.
      NFAIL = NFAIL + PROJEX ('SFL', PV, 90, -90, TOL)

*     PAR: parabolic.
      NFAIL = NFAIL + PROJEX ('PAR', PV, 90, -90, TOL)

*     MOL: Mollweide's projection.
      NFAIL = NFAIL + PROJEX ('MOL', PV, 90, -90, TOL)

*     AIT: Hammer-Aitoff.
      NFAIL = NFAIL + PROJEX ('AIT', PV, 90, -90, TOL)

*     COP: conic perspective.
      PV(1) =  60D0
      PV(2) =  15D0
      NFAIL = NFAIL + PROJEX ('COP', PV, 90, -25, TOL)

*     COE: conic equal area.
      PV(1) =  60D0
      PV(2) = -15D0
      NFAIL = NFAIL + PROJEX ('COE', PV, 90, -90, TOL)

*     COD: conic equidistant.
      PV(1) = -60D0
      PV(2) =  15D0
      NFAIL = NFAIL + PROJEX ('COD', PV, 90, -90, TOL)

*     COO: conic orthomorphic.
      PV(1) = -60D0
      PV(2) = -15D0
      NFAIL = NFAIL + PROJEX ('COO', PV, 85, -90, TOL)

*     BON: Bonne's projection.
      PV(1) = 30D0
      NFAIL = NFAIL + PROJEX ('BON', PV, 90, -90, TOL)

*     PCO: polyconic.
      NFAIL = NFAIL + PROJEX ('PCO', PV, 90, -90, TOL)

*     TSC: tangential spherical cube.
      NFAIL = NFAIL + PROJEX ('TSC', PV, 90, -90, TOL)

*     CSC: COBE quadrilateralized spherical cube.
      NFAIL = NFAIL + PROJEX ('CSC', PV, 90, -90, 4D-2)

*     QSC: quadrilateralized spherical cube.
      NFAIL = NFAIL + PROJEX ('QSC', PV, 90, -90, TOL)

*     HPX: HEALPix projection.
      PV(1) = 4D0
      PV(2) = 3D0
      NFAIL = NFAIL + PROJEX ('HPX', PV, 90, -90, TOL)

*     XPH: HEALPix polar, aka "butterfly" projection.
      NFAIL = NFAIL + PROJEX ('XPH', PV, 90, -90, TOL)


      IF (NFAIL.NE.0) THEN
        WRITE (*, 60) NFAIL
 60     FORMAT (/,'FAIL:',I5,' closure residuals exceed reporting ',
     :    'tolerance.')
      ELSE
        WRITE (*, 70)
 70     FORMAT (/,'PASS: All closure residuals are within reporting ',
     :    'tolerance.')
      END IF

      END

*-----------------------------------------------------------------------
      INTEGER FUNCTION PROJEX (PCODE, PV, NORTH, SOUTH, TOL)
*-----------------------------------------------------------------------
*   PROJEX exercises the spherical projection routines.
*
*   Given:
*      PCODE    C*3      Projection code.
*      PV       D(0:29)  Projection parameters.
*      NORTH    I        Northern cutoff latitude, degrees.
*      SOUTH    I        Southern cutoff latitude, degrees.
*      TOL      D        Reporting tolerance, degrees.
*-----------------------------------------------------------------------
      INTEGER   J, LAT, LNG, NFAIL, NORTH, SOUTH, STAT1(361),
     :          STAT2(361), STATUS
      DOUBLE PRECISION DLAT, DLATMX, DLNG, DLNGMX, DR, DRMAX, LAT1,
     :          LAT2(361), LNG1(361), LNG2(361), PV(0:29), R, THETA,
     :          TOL, X(361), X1(361), X2(361), Y(361), Y1(361), Y2(361)
      CHARACTER PCODE*3

*     On some systems, such as Sun Sparc, the struct MUST be aligned
*     on a double precision boundary, done here using an equivalence.
*     Failure to do this may result in mysterious "bus errors".
      INCLUDE 'prj.inc'
      INTEGER   PRJ(PRJLEN)
      DOUBLE PRECISION DUMMY
      EQUIVALENCE (PRJ,DUMMY)

      DOUBLE PRECISION D2R, PI
      PARAMETER (PI = 3.141592653589793238462643D0)
      PARAMETER (D2R = PI/180D0)
*-----------------------------------------------------------------------
      STATUS = PRJINI(PRJ)

      DO 10 J = 0, 29
        STATUS = PRJPUT (PRJ, PRJ_PV, PV(J), J)
 10   CONTINUE

      STATUS = PRJPUT (PRJ, PRJ_CODE, PCODE, 0)

*     Uncomment the next line to test alternative initializations of
*     projection parameters.
*     STATUS = PRJPUT (PRJ, PRJ_R0, 180D0/PI, 0)

      WRITE (*, 20) PCODE, NORTH, SOUTH, TOL
 20   FORMAT ('Testing ',A3,'; latitudes',I3,' to',I4,
     :        ', reporting tolerance',1PG8.1,' deg.')

      NFAIL  = 0
      DLNGMX = 0D0
      DLATMX = 0D0

      DO 80 LAT = NORTH, SOUTH, -1
        LAT1 = DBLE(LAT)

        J = 1
        DO 30 LNG = -180, 180
          LNG1(J) = DBLE(LNG)
          J = J + 1
 30     CONTINUE

        STATUS = PRJS2X (PRJ, 361, 1, 1, 1, LNG1, LAT1, X, Y, STAT1)
        IF (STATUS.EQ.1) THEN
          WRITE (*, 40) PCODE, STATUS
 40       FORMAT (3X,A3,'(S2X) ERROR',I2)
          GO TO 80
        END IF

        STATUS = PRJX2S (PRJ, 361, 0, 1, 1, X, Y, LNG2, LAT2, STAT2)
        IF (STATUS.EQ.1) THEN
          WRITE (*, 50) PCODE, STATUS
 50       FORMAT (3X,A3,'(X2S) ERROR',I2)
          GO TO 80
        END IF

        LNG = -180
        DO 70 J = 1, 361
          IF (STAT1(J).NE.0) GO TO 70

          IF (STAT2(J).NE.0) THEN
            WRITE (*, 55) PCODE, LNG1(J), LAT1, X(J), Y(J), STAT2(J)
 55         FORMAT (3X,A3,'(X2S): lng1 =',F20.15,'  lat1 =',F20.15,/,
     :              '                x =',F20.15,'     y =',F20.15,
     :              '  ERROR',I3)
            GO TO 70
          END IF

          DLNG = ABS(LNG2(J) - LNG1(J))
          IF (DLNG.GT.180D0) DLNG = ABS(DLNG-360D0)
          IF (ABS(LAT).NE.90 .AND. DLNG.GT.DLNGMX) DLNGMX = DLNG
          DLAT = ABS(LAT2(J) - LAT1)
          IF (DLAT.GT.DLATMX) DLATMX = DLAT

          IF (DLAT.GT.TOL) THEN
            NFAIL = NFAIL + 1
            WRITE (*, 60) PCODE, LNG1(J), LAT1, X(J), Y(J), LNG2(J),
     :                    LAT2(J)
 60         FORMAT (8X,A3,': lng1 =',F20.15,'  lat1 =',F20.15,/,
     :              8X,'        x =',F20.15,'     y =',F20.15,/,
     :              8X,'     lng2 =',F20.15,'  lat2 =',F20.15)
          ELSE IF (ABS(LAT).NE.90) THEN
            IF (DLNG.GT.TOL) THEN
              NFAIL = NFAIL + 1
              WRITE (*, 60) PCODE, LNG1(J), LAT1, X(J), Y(J),
     :                      LNG2(J), LAT2(J)
             END IF
          END IF
 70     CONTINUE
 80   CONTINUE

      WRITE (*, 90) DLNGMX, DLATMX
 90   FORMAT (13X,'Maximum residual (sky): lng',1P,E8.1,'   lat',E8.1)


*     Test closure at points close to the reference point.
      R = 1.0
      THETA = -180D0

      DRMAX = 0D0

      DO 140 J = 1, 12
        X1(1) = R*COS(THETA*D2R)
        Y1(1) = R*SIN(THETA*D2R)

        STATUS = PRJX2S (PRJ, 1, 1, 1, 1, X1, Y1, LNG1, LAT1, STAT2)
        IF (STATUS.NE.0) THEN
          WRITE (*, 100) PCODE, X1(1), Y1(1), STATUS
 100      FORMAT (8X,A3,'(X2S):   x1 =',F20.15,'    y1 =',F20.15,
     :            '  ERROR',I3)
          GO TO 130
        END IF

        STATUS = PRJS2X (PRJ, 1, 1, 1, 1, LNG1, LAT1, X2, Y2, STAT1)
        IF (STATUS.NE.0) THEN
          WRITE (*, 110) PCODE, X1(1), Y1(1), LNG1(1), LAT1, STATUS
 110      FORMAT (3X,A3,':   x1 =',F20.15,'    y1 =',F20.15,/,
     :            3X,'      lng =',F20.15,'   lat =',F20.15,'  ERROR',
     :            I3)
          GO TO 130
        END IF

        DR = SQRT((X2(1)-X1(1))**2 + (Y2(1)-Y1(1))**2)
        IF (DR.GT.DRMAX) DRMAX = DR
        IF (DR.GT.TOL) THEN
          NFAIL = NFAIL + 1
          WRITE (*, 120) PCODE, X1(1), Y1(1), LNG1(1), LAT1, X2(1),
     :                   Y2(1)
 120      FORMAT (8X,A3,':   x1 =',F20.15,'    y1 =',F20.15,/,
     :            8X,'      lng =',F20.15,'   lat =',F20.15,/,
     :            8X,'       x2 =',F20.15,'    y2 =',F20.15)
        END IF

 130    R = R/10D0
        THETA = THETA + 15D0
 140  CONTINUE

      WRITE (*, 150) DRMAX
 150  FORMAT (13X,'Maximum residual (ref):  dR',1PE8.1)


      PROJEX = NFAIL

      END
