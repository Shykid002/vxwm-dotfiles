const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#12151b", /* black   */
  [1] = "#545B4E", /* red     */
  [2] = "#A98B5D", /* green   */
  [3] = "#C79F60", /* yellow  */
  [4] = "#DAB068", /* blue    */
  [5] = "#E3BB6D", /* magenta */
  [6] = "#DFC07E", /* cyan    */
  [7] = "#c3c4c6", /* white   */

  /* 8 bright colors */
  [8]  = "#5c6371",  /* black   */
  [9]  = "#545B4E",  /* red     */
  [10] = "#A98B5D", /* green   */
  [11] = "#C79F60", /* yellow  */
  [12] = "#DAB068", /* blue    */
  [13] = "#E3BB6D", /* magenta */
  [14] = "#DFC07E", /* cyan    */
  [15] = "#c3c4c6", /* white   */

  /* special colors */
  [256] = "#12151b", /* background */
  [257] = "#c3c4c6", /* foreground */
  [258] = "#c3c4c6",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
