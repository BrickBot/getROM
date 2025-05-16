# getROM
Tools and utilities from dumping the ROM from an RCX, which is often then used by RCX emulators.

## Obtaining a ROM Image
Based on both original instructions [posted here and accessed via archive.org](https://web.archive.org/web/20190814213047/http://www.crynwr.com/lego-robotics/rom-image.html)
as well as more recent documentation (plus a patch file) [posted on the RCXSimulator site](https://www4.cs.fau.de/~felser/RCXSimulator/#ROMimg).

Here is one set of steps you might follow to obtain an image:

1. Get and compile `send.c`.
   * Per the source code comments, this should compile under IRIX, Linux, and Solaris with `cc send.c -o send`

2. Make a copy of the firm0309.lgo firmware file.

3. Apply the "getROM.diff" patch to this copied firmware file.

   The individual modifications applied to the firmware file are follows:
   
   Search for S11396D0, delete that line, and replace it with:
   ```
   S11396D0B2D6AEA0ACB6A7A49BB8BFD0B23CAE3055
   ```
   Search for S11396F0, delete that line, and replace it with:
   ```
   S11396F0A998BFF0AD6AA21CAF50AABCA38899FA7E
   ```
   Search for S113BFD0, delete that line, plus the two that follow, and replace them with:
   ```
   S113BFD06E7E001C6E76001D6B86BFC06E7E001EDA
   S113BFE06E76001F6B86BFC2FECB5A00A1F600001E
   S113BFF06B06BFC26DF66B06BFC06DF65A00BB9AE6
   ```
   Save this file.

4. Download the new firmware file to the RCX.  Any standard RCX firmware download tool should suffice.
   * If you want a Unix firmware downloader with C source, get and compile firmdl.c.

5. Get and perhaps edit `getrom.pl`. As is, this program assumes you are running under some flavor of Unix and that you have Perl 5 installed. It also assumes that the send program is in your path.
   * This also appears to work under Cygwin on Windows

6. Run `getrom.pl` and redirect its stdout to a file. When `getrom.pl` completes, this file should contain an image of the ROM in s-record format.

7. Don't forget to reinstall the normal firmware once you've got your ROM image.


## Additional Resources
Further information regarding the RCX ROM has been posted on the [RCX Internals site](http://www.mralligator.com/rcx/#Rom).

## Alternatives
An open source implementation of the LEGO ROM for the MindStorms RCX is available under the [FOSS-RCX-ROM project](https://github.com/BrickBot/FOSS-RCX-ROM).
When possible use of an extracted LEGO ROM is preferred, as that better guarantees compabitility.

A version of ROM extracted from a LEGO MindStorms RCX 1.0 brick is also available with the
[LEGO releases](https://github.com/BrickBot/Archive/releases/tag/LEGO) posted under the
[BrickBot Archive](https://github.com/BrickBot/Archive) repository.
