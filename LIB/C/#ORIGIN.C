/*
 * File......: ORIGIN.C 
 * Author....: Steve Larsen
 * CIS ID....: 76370,1532
 * Date......: $Date:   03 Oct 1992 02:13:54  $
 * Revision..: $Revision:   1.0  $
 * Log file..: $Logfile:   C:/nanfor/src/origin.c_v  $
 *
 * This is an original work by K. Stephan Larsen and is placed in the
 * public domain.
 *
 * Modification history:
 * ---------------------
 *
 * $Log:   C:/nanfor/src/origin.c_v  $
 * 
 *    Rev 1.0   03 Oct 1992 02:13:54   GLENN
 * Initial revision.
 *
 */

#include "extend.h"

/* $DOC$
 * $FUNCNAME$
 *    FT_ORIGIN()
 * $CATEGORY$
 *    Environment
 * $ONELINER$
 *    Report the drive, path and filename of the current program
 * $SYNTAX$
 *    FT_ORIGIN() -> cString
 * $ARGUMENTS$
 *    None
 * $RETURNS$
 *    A string containing the full drive/directory/filename of
 *    the currently executing file.
 * $DESCRIPTION$
 *    Often users will install multiple copies of application software,
 *    especially on networks and in situations where the user is trying
 *    to get around a copy protection scheme.
 *
 *    This function enables you to learn the name and source location
 *    of the currently executing file, so that you may take whatever
 *    action you need to.
 *
 *    Requires DOS v3.xx and above.
 * $EXAMPLES$
 *    cMyFile := FT_ORIGIN()
 *
 *    IF cMyFile <> "C:\APPDIR\MYFILE.EXE"
 *       ?"Incorrect startup file.  Please remove/rename and start again"
 *       QUIT
 *    ENDIF
 * $INCLUDE$
 *    extend.h
 * $SEEALSO$
 *    FT_WHEREIS() FT_TREE()
 * $END$
 */

CLIPPER origin( void )
{
   extern char **__argv;
   _retc(  *__argv  );
}
